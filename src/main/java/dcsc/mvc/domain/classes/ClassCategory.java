package dcsc.mvc.domain.classes;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class ClassCategory {

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE , generator = "category_id_seq")
	@SequenceGenerator(sequenceName = "category_id_seq", allocationSize = 1 , name = "category_id_seq")
	private Long categoryId;
	
	private String categoryName;
	
	@OneToMany(mappedBy = "classCategory")
	@JsonIgnore
	private List<Classes> classes;
}
